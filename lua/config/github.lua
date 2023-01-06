require("octo").setup({
    mappings = {
        submit_win = {
            approve_review = { lhs = "<leader>ar", desc = "approve review" },
            comment_review = { lhs = "<leader>cr", desc = "comment review" },
            request_changes = { lhs = "<leader>rc", desc = "request changes review" },
            close_review_tab = { lhs = "<leader>x", desc = "close review tab" },
        },
    },
})
