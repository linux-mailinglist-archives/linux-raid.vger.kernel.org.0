Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C11716B177
	for <lists+linux-raid@lfdr.de>; Mon, 24 Feb 2020 22:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgBXVG4 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 24 Feb 2020 16:06:56 -0500
Received: from sender11-of-f72.zoho.eu ([31.186.226.244]:17322 "EHLO
        sender11-of-f72.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgBXVG4 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 24 Feb 2020 16:06:56 -0500
Received: from [172.30.220.169] (163.114.130.128 [163.114.130.128]) by mx.zoho.eu
        with SMTPS id 1582578410357410.7672451346118; Mon, 24 Feb 2020 22:06:50 +0100 (CET)
Subject: Re: [PATCH 1/1] Remove the legacy whitespace
To:     Xiao Ni <xni@redhat.com>
Cc:     ptoscano@redhat.com, ncroxon@redhat.com, linux-raid@vger.kernel.org
References: <1581428655-12316-1-git-send-email-xni@redhat.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <2cb11d60-de78-5991-40d2-811c74b632b2@trained-monkey.org>
Date:   Mon, 24 Feb 2020 16:06:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1581428655-12316-1-git-send-email-xni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 2/11/20 8:44 AM, Xiao Ni wrote:
> The whitespace between Environment= and the true value causes confusion.
> To avoid confusing other people in future, remove the whitespace to keep
> it a simple, unambiguous syntax
> 
> Signed-off-by: Xiao Ni <xni@redhat.com>

Applied!

Thanks,
Jes

